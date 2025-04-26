import { ChangeEvent, useState } from "react"

export type Option = {
    label: string
    value: string | number
}

export type PushEvent = {
    target: {
        name: string
        value: string | number
    }
}

type InputGroupProps = {
    id?: string
    name: string
    value: string | number
    type?: 'text' | 'number' | 'email' | 'password' | 'date' | 'tel'
    placeholder: string
    label: string
    options?: Option[]
    disable?: boolean
    limit?: number | null
    className?: string | null
    onChangeFnc?: (e: ChangeEvent<HTMLInputElement> | PushEvent) => void
    isHorizontal?: boolean
}

export default function InputGroup({ 
        name, 
        id = name, 
        value, 
        type = 'text', 
        placeholder,
        label,
        onChangeFnc, 
        options = [],
        disable = false, 
        limit = null,
        className = null,
        isHorizontal = false
    } : InputGroupProps) 
{
    const [show, setShow] = useState(false)
    const [isError, setIsError] = useState<string | null>(null)
    const [optionsFiltered, setOptionsFiltered] = useState<Option[]>(options)

    const onPushOption = (value: string) => {
        const e : PushEvent = {
            target: {
                name,
                value
            }
        }
        if(onChangeFnc != null)
            onChangeFnc(e);
    }

    const onChange = (e: ChangeEvent<HTMLInputElement> | PushEvent) => {
        if(limit) {
            if(limit < +e.target.value) {
                setIsError('Este valor supera el limite')
            } else {
                setIsError(null)
            }
        }
        if(onChangeFnc != null) {
            onChangeFnc(e)
        }

        if(e.target.value === '') {
            setOptionsFiltered(options)
            return
        }

        const filtered = options.filter(option => option.label.toLowerCase().includes((e as ChangeEvent<HTMLInputElement>).target.value.toLowerCase()))
        setOptionsFiltered(filtered)
    }
    
    return (
        <div className={isHorizontal ? 'condition-container' : `${className} input-group`}>
            <label htmlFor={id}>{label}</label>
            <input 
                disabled={disable}
                onFocus={() => setShow(true)}
                onBlur={() => (setTimeout(() => setShow(false), 100))}
                type={type} 
                name={name} 
                id={id} 
                value={value} 
                placeholder={placeholder}
                onChange={onChange}
                autoComplete="off"
                className={isError ? 'input-error' : ''}
            />

            {isError && (
                <p className="input-error-message">{isError}</p>
            )}

            {optionsFiltered.length > 0 && show && (
                <div className="input-options">
                    {optionsFiltered.map(option => (
                        <button type="button" key={option.value} onClick={() => onPushOption(option.label)}>{option.label}</button>
                    ))}
                </div>
            )}
        </div>
    )
}
