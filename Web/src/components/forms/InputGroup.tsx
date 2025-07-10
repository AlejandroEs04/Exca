import { ChangeEvent, useEffect, useState } from "react"

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
    type?: 'text' | 'number' | 'email' | 'password' | 'date' | 'tel' | 'currency'
    placeholder: string
    label: string
    disable?: boolean
    limit?: number | null
    className?: string | null
    onChangeFnc?: (e: ChangeEvent<HTMLInputElement>) => void
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
        disable = false, 
        limit = null,
        className = null,
        isHorizontal = false
    } : InputGroupProps) 
{
    const [isError, setIsError] = useState<string | null>(null)

    const onChange = (e: ChangeEvent<HTMLInputElement>) => {    
        if(limit) {
            if(+limit < +e.target.value) {
                setIsError('Este valor supera el limite')
            } else {
                setIsError(null)
            }
        }
        
        if(onChangeFnc != null) {
            onChangeFnc(e);
        }
    }

    function formatToCurrency(value: string | number): string {
        const num = typeof value === 'number' ? value : parseFloat(String(value).replace(/[^0-9.]/g, ''))
        if (isNaN(num)) return ''
        return new Intl.NumberFormat('es-MX', {
            style: 'currency',
            currency: 'MXN',
            minimumFractionDigits: 2,
        }).format(num)
    }
    useEffect(() => {
        if (type === 'currency') {
            const formatted = formatToCurrency(value);
            if (value !== formatted) {
                onChangeFnc?.({
                    // @ts-expect-error: Custom event for currency formatting
                    target: {
                        name,
                        value: formatted
                    }
                });
            }
        }
    }, [value, type, name]);
    
    
    return (
        <div className={isHorizontal ? 'condition-container g-2' : `${className} input-group`}>
            <label htmlFor={id}>{label}</label>
            <input 
                disabled={disable}
                type={type} 
                name={name} 
                id={id} 
                defaultValue={value} 
                placeholder={placeholder}
                onChange={onChange}
                autoComplete="off"
                className={`${isError ? 'input-error' : ''}`}
            />

            {isError && (
                <p className="input-error-message">{isError}</p>
            )}
        </div>
    )
}
